require './genotype'

class MiddlePointCrossover
  def initialize(matrix:)
    @original_matrix = matrix
  end

  def cross(parents:)
    parent_1, parent_2 = parents[0], parents[1]
    [generate_child(parent_1, parent_2), generate_child(parent_2, parent_1)]
  end

private
  def generate_child(parent_1, parent_2)
    Genotype.new cross_elements(parent_1.rows, parent_2.rows), cross_elements(parent_1.cols, parent_2.cols), @original_matrix
  end

  def cross_elements(parent_1_elements, parent_2_elements)
  	middle_point = (parent_1_elements.size / 2) - 1 #porque indexa desde cero , sino estoy agarrando mas de la mitad
  	start_point = rand(0..middle_point)
  	end_point = rand((start_point + 1)..(parent_1_elements.size - 1))

    crossed_elements = parent_1_elements[start_point..end_point]
    parent_2_elements.each do |elem|
      break if crossed_elements.size == parent_1_elements.size
      crossed_elements << elem unless crossed_elements.include? elem
    end
    crossed_elements
  end
end
