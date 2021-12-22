# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

class Question < ApplicationRecord
    validates :text, presence: true 

    has_many :answer_choices,
     primary_key: :id,
     foreign_key: :question_id,
     class_name: 'AnswerChoice'

     belongs_to :poll,
     primary_key: :id,
     foreign_key: :poll_id,
     class_name: 'Poll'

    has_many :responses,
    through: :answer_choices,
    source: :responses
 
    def results_n_plus_1 
        results = {}

        answer_choices.each do |ac|
            results[ac.text] = responses.count 
        end

        results
    end

    def results_2_queries
        results = {}
        self.answer_choices.includes(:responses).each do |ac|
            results[ac.text] = responses.count
        end
        results
    end

    def results_1_query_SQL
        acs = AnswerChoice.find_by_sql([<<-SQL, id])
            SELECT
                answer_choices.text, COUNT(responses.id) AS num_votes
            FROM 
                answer_choices
            JOIN
                responses ON answer_choices.id = responses.answer_choice_id
            WHERE
                answer_choices.question_id = ?
            GROUP BY
                answer_choices.id 
        SQL

        acs.inject({}) do |results, ac|
            results[ac.text] = ac.num_votes; results
        end

    end


    def results 

        acs = self.answer_choices
                .select('answer_choices.text, COUNT(responses.id) AS num_votes')
                .left_outer_joins(:responses)
                .group('answer_choices.id')



        acs.inject({}) do |results, ac|
            results[ac.text] = ac.num_votes; results
        end
    end

end
