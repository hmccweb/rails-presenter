require 'test_helper'

class PresentersBaseTest < ActiveSupport::TestCase
  test "presence of #each method" do
    assert Presenters::Base.instance_methods.include? :each
  end

  test "#each yields same presenter as itself by default" do
    Birthday.new.save

    birthdays = Birthday.all
    bp        = BirthdayPresenter.new(birthdays)

    bp.each do |b|
      assert_instance_of BirthdayPresenter, b
    end
  end

  test "#each yields override presenter" do
    Birthday.new.save

    birthdays = Birthday.all
    bp        = BirthdayPresenter.new(birthdays)

    bp.each('wrapping_paper') do |b|
      assert_instance_of WrappingPaperPresenter, b
    end
  end

  test "#model returns __getobj__" do
    b  = Birthday.new
    bp = BirthdayPresenter.new(b)

    assert_equal b, bp.model
  end

  test "#relation returns __getobj__" do
    b  = Birthday.new
    bp = BirthdayPresenter.new(b)

    assert_equal b, bp.relation
  end
end
