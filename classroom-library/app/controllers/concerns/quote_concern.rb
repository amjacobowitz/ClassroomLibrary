module QuoteConcern
  extend ActiveSupport::Concern

  included do
    helper_method :random_quote
  end

  def random_quote
    id = rand(1..40)
    random_quote = Quote.find(id)
    session[:random_quote] = random_quote
  end

end
