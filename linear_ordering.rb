require 'genotype'

def generate_initial_population(amount_of_samples, original_matrix)
  population = Set.new
  dimension = original_matrix[0].size
  amount_of_samples.times do
    population << Genotype.new [*0..dimension - 1].shuffle [*0..dimension - 1].shuffle original_matrix
  end
  population
end

genotype = Genotype.new [0, 1, 2], [2, 1, 0], [[:a, :b, :c], [:d, :e, :f], [:g, :h, :i]]
puts genotype.create_permuted_matrix
