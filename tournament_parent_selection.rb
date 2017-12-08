require './genotype'

class TournamentParentSelection
  def initialize(num_of_random_elections:, original_matrix:)
    @num_of_random_elections = num_of_random_elections
    @original_matrix = original_matrix
  end

  def select(population:)
    possible_parents = population.to_a.sample(@num_of_random_elections) #sample no funca con sets asi que hay que pasarlo a array
    Genotype.select_best(candidates: possible_parents, matrix: @original_matrix)
  end
end
