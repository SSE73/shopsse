json.array!(@ed_izms) do |ed_izm|
  json.extract! ed_izm, :id, :name, :name_long  
  json.url ed_izm_url(ed_izm, format: :json)
end
