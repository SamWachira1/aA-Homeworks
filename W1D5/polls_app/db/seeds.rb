# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


ActiveRecord::Base.transaction do 
    User.destroy_all
    Poll.destroy_all
    Question.destroy_all
    AnswerChoice.destroy_all
    Response.destroy_all


    u1 = User.create!(username: "daytrip1")
    u2 = User.create!(username: "kidCwebby")
    u3 = User.create!(username: 'blackjack')
    u4 = User.create!(username: 'blk_lives_matter')


    p1 = Poll.create!(title: 'Popular Agenda Poll', author_id: u1.id)    
        q1 = Question.create!(text: 'BBB or DACA', poll_id: p1.id)
         a1 = AnswerChoice.create!(text: 'DACA', question_id: q1.id)
         a2 = AnswerChoice.create!(text: 'BBB', question_id: q1.id)


    p2 = Poll.create!(title: 'Sports Poll', author_id: u2.id)
      q2 = Question.create!(text: 'Hockey or Football', poll_id: p2.id)
        a4 = AnswerChoice.create!(text: 'Hockey', question_id: q2.id )
        a5 = AnswerChoice.create!(text: 'Football', question_id: q2.id)

    r1 = Response.create!(
      respondent_id: u3.id,
      answer_choice_id: a1.id)

    r2 = Response.create!(
      respondent_id: u1.id,
      answer_choice_id: a4.id
    )
    r3 = Response.create!(
      respondent_id: u2.id,
      answer_choice_id: a2.id)

    r4 = Response.create!(
      respondent_id: u3.id,
      answer_choice_id: a4.id)

     r5 = Response.create!(
    respondent_id: u4.id,
    answer_choice_id: a1.id)

  # r4 = Response.create!(
  #   respondent_id: u1.id,
  #   answer_choice_id: a2.id
  # )


end