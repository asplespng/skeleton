class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

Document.ready? do
  Element.find('.btn').on :click do
    person = Person.new('Per')
    alert "A button was clicked! by #{person.name}"
  end
end
