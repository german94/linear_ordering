require './genotype'

class TournamentParentSelection
  def initialize(num_of_random_elections:, original_matrix:)
    @num_of_random_elections = num_of_random_elections
    @original_matrix = original_matrix
  end

  def select(population:)
    possible_parents = population.to_a.sample(@num_of_random_elections)
    first_parent = Genotype.select_best(candidates: possible_parents)
    second_parent = select_second_best(population: possible_parents, first_best: first_parent)
    [first_parent, second_parent]
  end

private
  def select_second_best(population:, first_best:)
    criteria = Proc.new do |current, candidate|
      if first_best == candidate
        current
      elsif first_best == current
        candidate
      else
        candidate.fitness_value > current.fitness_value ? candidate : current
      end
    end
    Genotype.select(candidates: population,
                selection_criteria: criteria)
  end
end
