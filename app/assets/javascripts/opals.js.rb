Document.ready? do
  Element.find('.btn').on :click do
    alert "A button was clicked!"
  end
end
