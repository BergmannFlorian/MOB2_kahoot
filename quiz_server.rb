#!/usr/bin/env ruby
#
# Run me to launch the REST server but before install `sinatra` once with `gem install sinatra`

require 'sinatra'
require 'json'

# Modelize a question
class Question < Struct.new(:caption, :answers, :correct_answer_index, :hint)

  # friendly constructor
  def initialize(caption: "", answers: [], correct_answer_index: 0, hint: "")
    self.caption = caption
    self.answers = answers
    self.correct_answer_index = correct_answer_index
    self.hint = hint
  end

  def to_json(options = {})
    to_h.to_json(options)
  end
  
  class << self
    # Have a bunch of fixed questions
    def all
      [
        Question.new(
          caption: "2+2",
          answers: ["1", "2", "4"],
          correct_answer_index: 2,
          hint: "Come'on"
        ),
        Question.new(
          caption: "Meaning of life?",
          answers: ["God", "42", "Me"],
          correct_answer_index: 1,
          hint: "H2G2"
        ),
        Question.new(
          caption: "May the Force be with you",
          answers: ["Star wars", "Forest Gump", "American pie"],
          correct_answer_index: 0,
          hint: "Skywalker"
        )
      ]
    end
  end
end

#
# Server end-points
#

get '/questions/next' do
  content_type  :json
  Question.all.sample.to_json
end

