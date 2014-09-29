class BirthdaysController < ApplicationController
  def index
    @birthdays = present(Birthday.all)
  end
end
