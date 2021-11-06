require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
         super('questions.db')
         self.type_translation = true
         self.results_as_hash = true
    end

    # def self.get_first_row(*args)
    #     instance.get_first_row(*args)
    # end

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

    def authored_questions
        Question.find_by_author_id(id)
    end

    def authored_replies
        Reply.find_by_user_id(user_id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
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

end

class Reply
    attr_reader :id, :question_id, :parent_reply_id, :author_id, :body

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

   


    




end




 



