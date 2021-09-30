require 'css_parser'
require 'json'

include CssParser

# load a string
parser = CssParser::Parser.new

# load a local file, setting the base_dir and media_types
parser.load_file!('all.css', 'css', :screen)

# lookup a rule by a selector and media type
parser.find_by_selector('.fa-', [:all])

def clean_selector_for_json(selector)
  s = selector
  s = s.split("::")[0]
  s = s.split(".")
  s = "#{s[1]} #{s[2]}".strip
end

def reject_icon?(icon)
  reject = true
  reject = false if icon.include?('fa-')
  reject = true if icon.include?('fad ')
  reject = true if icon.include?('fa-duotone ')

  reject = true if icon.include?(':')

  reject
end

def clean_array(icons)
  clean_array = Array.new
  icons.each do |icon|
    clean_array << icon unless reject_icon?(icon)
  end

  clean_array.uniq.sort
end

def prepare_hash(array)
  collection = Hash.new
  array.each_with_index do |entry, index|
    collection["#{index}"] = "fa-regular #{entry}"
  end

  collection
end

icons = Array.new
parser.each_selector(:all) do |selector, _d, _s|
  icons << clean_selector_for_json(selector)
end

puts prepare_hash(clean_array(icons)).to_json
