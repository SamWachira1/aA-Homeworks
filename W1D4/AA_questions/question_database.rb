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

end




class Reply

    attr_reader :id, :question_id, :parent_reply_id, :author_id, :body

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


end




 



