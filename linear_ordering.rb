require './genotype'

class LinearOrderingSolutionsGenerator
  def initialize(population_size:, original_matrix:, max_iterations:, parent_selection_criteria:, crossover_criteria:, mutation_criteria:)
    @population_size = population_size
    @original_matrix = original_matrix
    @max_iterations = max_iterations
    @parent_selection_criteria = parent_selection_criteria
    @crossover_criteria = crossover_criteria
    @mutation_criteria = mutation_criteria
  end

  def dimension
    @original_matrix.size
  end

  def generate_solution
    generate_initial_population
    set_initial_solution
    @max_iterations.times do
      parents = @parents_selection_criteria.select(population: @population)
      offspring = @crossover_criteria.cross(parents: parents)
      offspring = mutation_criteria.mutate(offspring: offspring) #falta implementar algun criterio de mutacion
      select_survivors  #falta implementarlo y decidir si lo vamos a hacer configurable o no (depende de cuanto vayamos a querer experimentar con esto)
      select_best
    end
    @best_solution
  end

private
  def select_best
    candidate = Genotype.select_best(candidates: @population, matrix: original_matrix)
    @best_solution = @best_solution.fitness_value < candidate.fitness_value ? candidate : @best_solution
  end

  def set_initial_solution
    @best_solution = @population.first
  end

  def generate_initial_population
   @population = Set.new # hay alguna razon  por la que no se define population en el initialize?
    loop do
      row = [*0..dimension - 1].shuffle
      column = [*0..dimension - 1].shuffle
      @population << Genotype.new(row, column, @original_matrix)
      break if @population.size == @population_size
    end
  end

end
