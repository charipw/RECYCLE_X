if @item.id != nil
  json.show render(partial: "items/show", formats: :html, locals: {item: @item})
else
  json.form render(partial: "items/form", formats: :html, locals: {item: @item})
end
