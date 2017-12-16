require './genotype'

class NormalMultiPointCrossover
  def initialize(matrix:)
    @original_matrix = matrix
  end

  def cross(parents:)
    parent_1, parent_2 = parents[0], parents[1]
    [generate_child(parent_1, parent_2), generate_child(parent_2, parent_1)]
  end

private
  def generate_child(parent_1, parent_2)
    Genotype.new cross_elements(parent_1.permutations, parent_2.permutations), @original_matrix
  end

    def cross_elements(parent_1_elements, parent_2_elements)
  	middle_point = (parent_1_elements.size / 2) - 1 #porque indexa desde cero , sino estoy agarrando mas de la mitad
  	start_point = rand(0..middle_point)
  	end_point = rand((start_point + 1)..(parent_1_elements.size - 1))
    crossed_elements = parent_1_elements[start_point..end_point]
    child = []
    parent_2_elements.each do |elem|
      child.concat crossed_elements if child.size == start_point
      child << elem unless crossed_elements.include? elem
    end
    child
  end


end
