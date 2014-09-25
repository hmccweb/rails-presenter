class GiftsController < ApplicationController
  def index
    @gifts = present(Gift.all, WrappingPaperPresenter)
  end
end
