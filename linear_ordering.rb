require './genotype'

class LinearOrderingSolutionsGenerator
  def initialize(population_size:, original_matrix:, max_iterations:, parent_selection_criteria:, crossover_criteria:, mutation_criteria:, survivor_criteria:)
    @population_size = population_size
    @original_matrix = original_matrix
    @max_iterations = max_iterations
    @parent_selection_criteria = parent_selection_criteria
    @crossover_criteria = crossover_criteria
    @mutation_criteria = mutation_criteria
    @survivor_criteria = survivor_criteria
  end

  def dimension
    @original_matrix.size
  end

  def generate_solution
    generate_initial_population
    set_initial_solution
    @max_iterations.times do
    	firstParent = @parent_selection_criteria.select(population: @population)#arreglar para no tener que repetir la busqueda
    	secondParent = @parent_selection_criteria.select(population: @population)
   		offspring = @crossover_criteria.cross(parents: [firstParent, secondParent])
   		@mutation_criteria.mutate(offspring: offspring, original_matrix: @original_matrix) 
   		@survivor_criteria.select(population: @population)
		addNewOffspring(offspring)
		select_best
    end
    @best_solution
  end

private
  def select_best
    candidate = Genotype.select_best(candidates: @population)
    @best_solution = @best_solution.fitness_value < candidate.fitness_value ? candidate : @best_solution
  end

  def addNewOffspring(offspring)
 	@population.add(offspring[0])
 	@population.add(offspring[1])
  end
  
  def set_initial_solution
    @best_solution = @population.first
  end

  def generate_initial_population
   @population = Set.new 
    loop do
      row = [*0..dimension - 1].shuffle
      column = [*0..dimension - 1].shuffle
      @population << Genotype.new(row, column, @original_matrix)
      break if @population.size == @population_size
    end
  end

end
