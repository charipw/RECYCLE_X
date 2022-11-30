if @item.persisted?
  json.form render(partial: "items/show")
else
  json.form render(partial: "items/form", formats: :html, locals: {item: @item})
end
