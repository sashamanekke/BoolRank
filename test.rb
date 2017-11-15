
def generate_combinations(props)
  all_combinations = []

  props.each_with_index do |p1, index|
    props[(index + 1)..-1].each do |p2|
      all_combinations << [p1,p2]
    end
  end

  all_combinations
end

props = ['a','b','c','d','e','f']

p generate_combinations(props).sample
