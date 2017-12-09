require './genotype'

class TournamentParentSelection
  def initialize(num_of_random_elections:, original_matrix:)
    @num_of_random_elections = num_of_random_elections
    @original_matrix = original_matrix
  end

  def select(population:)
    possible_parents = population.to_a.sample(@num_of_random_elections) #sample no funca con sets asi que hay que pasarlo a array
    first_parent = Genotype.select_best(candidates: possible_parents)
    second_parent = select_second_best(population: possible_parents, first_best: first_parent)
    [first_parent, second_parent]
  end

private
  def select_second_best(population:, first_best:)
    criteria = Proc.new do |current, candidate|
      return current if candidate == first_best
      return candidate if current == first_best
      candidate.fitness_value > current.fitness_value ? candidate : current
    end
    Genotype.select(candidates: population,
                selection_criteria: criteria)
  end
end
