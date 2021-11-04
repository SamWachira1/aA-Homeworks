require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton
    def initialize
         super('questions.db')
         self.type_translation = true
         self.results_as_hash = true
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
        user_data = QuestionsDatabase.get_first_row(<<-SQL, id: id)
            SELECT
                users.*
            FROM 
                users
            WHERE
                users.id = :id 
        SQL
        user_data.nil? ? nil : User.new(user_data)
    end




end


 



