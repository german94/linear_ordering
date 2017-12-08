class MiddlePointCrossover
  def cross(parents:)
    parent_1, parent_2 = parents[0], parents[1]
    [generate_child(parent_1, parent_2), generate_child(parent_2, parent_1)]
  end

private
  def generate_child(parent_1, parent_2)
    Genotype.new cross_elements(parent_1.rows, parent_2.rows), cross_elements(parent_1.cols, parent_2.cols)
  end

  def cross_elements(parent_1_elements, parent_2_elements)
    middle_point = parent_1_elements.size / 2
    crossed_elements = parent_1_elements[0..middle_point] #chequear esto, el 0 y middle_point estan incluidos
    parent_2_elements.each do |elem|
      break if crossed_elements.size == parent_1_elements
      crossed_elements << elem
    end
    cross_elements
  end
end
