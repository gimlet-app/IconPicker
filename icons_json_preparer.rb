require 'json'

## OUTPUTS
FILENAME = 'iconpicker-6.5.1.json'
DIRPATH = 'dist'

file = File.read('dist/fontawesome-pro-6.5.1-web/metadata/icons.json')
icons = JSON.parse(file)
fa_icons = []

def icon_options(icon, attrs)
  options = []
  attrs["styles"].each do |style|
    options << "fa-#{style} fa-#{icon}"
  end
  options
end

def prepare_hash(array)
  collection = Hash.new
  array.each_with_index do |entry, index|
    collection["#{index}"] = "#{entry}"
  end

  collection
end

icons.each do |icon, attrs|
  icon_options(icon, attrs).each do |option|
    fa_icons << option
  end
end

File.open("#{DIRPATH}/#{FILENAME}","w") do |f|
  f.write(JSON.pretty_generate(prepare_hash(fa_icons)))
end

