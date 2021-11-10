require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
         super('question.db')
         self.type_translation = true
         self.results_as_hash = true
    end

    # def self.get_first_row(*args)
    #     instance.get_first_row(*args)
    # end

    # def self.get_first_value(*args)
    #     instance.get_first_value(args)
    # end

    def self.last_insert_row_id(*args)
        instance.last_insert_row_id(args)
    end

end

class User 
    attr_reader :id 
    attr_accessor :fname, :lname 

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map {|datum| User.new(datum)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def self.find_by_id(id)
         user_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                users.*
            FROM 
                users
            WHERE
                users.id = ?
        SQL

        User.new(user_data[0])
    end

    def self.find_by_name(fname, lname)
        attrs = { fname: fname, lname: lname }
        user_data = QuestionsDatabase.instance.execute(<<-SQL, attrs)
            SELECT
                users.*
            FROM 
                users
            WHERE 
                users.fname = :fname AND users.lname = :lname
         SQL

        User.new(user_data[0])
    end


#     CREATE TABLE questions (
#     id INTEGER PRIMARY KEY,
#     title VARCHAR(255) NOT NULL,
#     body TEXT NOT NULL,
#     author_id INTEGER NOT NULL,

#     FOREIGN KEY (author_id) REFERENCES users(id)
# );

    # CREATE TABLE question_likes (
    #     id INTEGER PRIMARY KEY,
    #     user_id INTEGER NOT NULL,
    #     question_id INTEGER NOT NULL,
    #     FOREIGN KEY (user_id) REFERENCES users(id),
    #     FOREIGN KEY (question_id) REFERENCES questions(id)
    # );


    def average_karma
        user_data = QuestionsDatabase.instance.execute(<<-SQL, author_id, self.id)
            SELECT
              CAST(COUNT(question_likes.id)) AS FLOAT / 
                count(DISTINCT(questions.id)) as Avg_karma
            FROM
                questions
            LEFT OUTER JOIN
                question_likes
            ON
                question.id = quesiton_likes.question_id
            WHERE
                quesitons.author_id = :author_id 
            SQL
    end


    def authored_questions
        Question.find_by_author_id(id)
    end

    def authored_replies
        Reply.find_by_user_id(id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(id)
    end

    def save
        if @id 
            QuestionsDatabase.instance.execute(<<-SQL, fname, lname, id)
            UPDATE
                users
            SET
                 fname = :fname, lname = :lname 
            WHERE
                users.id = :id 
            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            INSERT INTO
                users (fname, lname)
            VALUES
                (:fname, :lname)
            SQL
        end
        self
    end
 
    def self.delete_data(fname, lname)
       user_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname) 
            DELETE FROM
                users
            WHERE
                fname = :fname AND lname = :lname 
        SQL
    end

end

class Question
    attr_reader :id 
    attr_accessor :title, :body, :author_id

    def self.all
          question_data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
          question_data.map {|datum| Question.new(datum)}
    end

    def self.find_by_id(id)
        questions_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT 
              questions.*
            FROM
              questions
            WHERE
             questions.id = :id 
        SQL

       questions_data.map {|datum| Question.new(datum)}
    end
    

    def self.find_by_author_id(author_id)
        questions_data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT 
            questions.*
        FROM 
            questions
        WHERE
            questions.author_id = :author_id
        SQL

        Question.new(questions_data.first)
    end

      def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
      end

      def self.most_liked(n)
        QuestionLike.most_liked_questions(n)
      end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        User.find_by_id(author_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def save 
        if @id 
             QuestionsDatabase.instance.execute(<<-SQL, id)
            UPDATE
                questions
            SET 
                (:title, :body, :author_id) 
            WHERE 
                question.id = :id 
            SQL
        else    
            QuestionsDatabase.instance.execute(<<-SQL, title, body, author_id )
            INSERT INTO
                questions(title, body, author_id)
            VALUES
                (:title, :body, :author_id)
            SQL
        end
        self
    end

    
end

class Reply
    attr_reader :id
    attr_accessor :question_id, :parent_reply_id, :author_id, :body

    def self.find(id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                replies.*
            FROM
                replies
            WHERE
                replies.id = :id 
        SQL
    
        Reply.new(reply_data.first)
    end

    def self.find_by_parent_id(parent_reply_id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
            SELECT
            replies.*
            FROM
            replies
            WHERE
            replies.parent_reply_id = :parent_reply_id
        SQL
        Reply.new(reply_data.first)
    end

    def self.find_by_user_id(user_id)
        reply_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                replies.*
            FROM
                replies
            WHERE
                replies.author_id = :user_id  
        SQL
        Reply.new(reply_data.first)
    end

    def self.find_by_question_id(question_id)
        question_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT 
                replies.*
            FROM
                replies
            WHERE
                replies.question_id = :question_id
        SQL

        return nil if question_data.empty?
        
        question_data.map {|datum| Reply.new(datum)}
    end


    def self.all
        reply_data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        reply_data.map {|datum| Reply.new(datum)}
    end

    def initialize(options)
        @id = options["id"]
        @question_id = options["question_id"]
        @parent_reply_id = options["parent_reply_id"]
        @author_id = options["author_id"]
        @body = options["body"]
    end

    def author
        User.find_by_id(author_id)
    end

    def question
        Question.find_by_id(id)
    end

    def parent_reply
        Reply.find(parent_reply_id)
    end

    def child_replies
        Reply.find_by_parent_id(id)
    end

    def save
        if @id 
            reply_data = QuestionsDatabase.instance.execute(<<-SQL, id)
            UPDATE
                replies
            SET
                (:question_id, :parent_reply_id, :author_id, :body)
            WHERE
                replies.id = :id 

            SQL
        else
            QuestionsDatabase.instance.execute(<<-SQL, question_id, parent_reply_id, author_id, body)
            INSERT INTO
                replies(question_id, parent_reply_id, author_id, body)
            VALUES
                (:question_id, :parent_reply_id, :author_id, :body)
            SQL
            @id = QuestionsDatabase.instance.last_insert_row_id
        end
    end


    def delete_reply


    end

end


# CREATE TABLE question_follows (
#     id INTEGER PRIMARY KEY,
#     user_id INTEGER NOT NULL,
#     question_id INTEGER NOT NULL,

#     FOREIGN KEY (user_id) REFERENCES users(id),
#     FOREIGN KEY (question_id) REFERENCES questions(id)
# );

class QuestionFollow

    attr_reader :id
    attr_accessor :user_id, :question_id

    def self.all
        question_follow_data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        question_follow_data.map  {|datum| QuestionFollow.new(datum)}
    end

    def initialize(options)
        @id = options["id"]
        @user_id = options["user_id"]
        @question_id = options["question_id"]
    end

    def self.followers_for_question_id(question_id)

        question_follow_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_follows
            ON 
                users.id = question_follows.user_id 
            WHERE
                question_follows.question_id = :question_id 
        SQL
        question_follow_data.map {|datum| User.new(datum)}
    end

    def self.followed_questions_for_user_id(user_id)
         question_follow_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
             questions.*
            FROM 
             questions
            JOIN
             question_follows
            ON 
             questions.id = question_follows.question_id
            WHERE
             question_follows.user_id = :user_id 
        SQL
        Question.new(question_follow_data.first)
    end

    def self.most_followed_questions(n)

        question_follow_data = QuestionsDatabase.instance.execute(<<-SQL, limit: n)
        SELECT
            questions.*
        FROM 
            questions
        JOIN
            question_follows
        ON 
            question_follows.question_id = questions.id
        GROUP BY
            questions.id 
        ORDER BY
            count(*) DESC
        LIMIT
            :limit 
        SQL

        question_follow_data.map { |question_data| Question.new(question_data) }
    end

end

# CREATE TABLE question_likes (
#     id INTEGER PRIMARY KEY,
#     user_id INTEGER NOT NULL,
#     question_id INTEGER NOT NULL,
#     FOREIGN KEY (user_id) REFERENCES users(id),
#     FOREIGN KEY (question_id) REFERENCES questions(id)
# );


class QuestionLike 
    def self.likers_for_question_id(question_id)
      question_like_data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
         users.*
        FROM
         users
        JOIN
          question_likes
        ON
         users.id = question_likes.user_id
        WHERE
          question_likes.question_id = :question_id
     SQL
         User.new(question_like_data.first)
    end

    def self.num_likes_for_question_id(question_id)
         question_like_data = QuestionsDatabase.instance.get_first_value(<<-SQL, question_id)
            SELECT
                COUNT(*) AS likes
            FROM 
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                questions.id = :question_id 
        SQL
    end

    def self.liked_questions_for_user_id(user_id) 
       question_like_data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes
            ON 
                questions.id = question_likes.user_id 
            WHERE
                question_likes.user_id = :user_id
        SQL

        Question.new(question_like_data.first)
    end

    def self.most_liked_questions(n)
        question_like_data = QuestionsDatabase.instance.execute(<<-SQL, limit: n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes
            ON 
                questions.id = question_likes.question_id
            GROUP BY
                questions.id
            ORDER BY
                COUNT(*) DESC
            LIMIT
                :limit
        SQL
        question_like_data.map {|datum| Question.new(datum)}
    end



end





 



