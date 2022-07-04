module ClassModule

  def can_be_archived?
    @silent || super
  end

end