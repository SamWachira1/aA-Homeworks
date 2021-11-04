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

        # return nil unless user_data.length > 0  
        User.new(user_data[0])
    end



end


 



