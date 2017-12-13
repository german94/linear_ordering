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

  def generate_solution(debug: true)
    generate_initial_population
    set_initial_solution
    @max_iterations.times do |i|
    	parents = @parent_selection_criteria.select(population: @population)
   		offspring = @crossover_criteria.cross(parents: parents)
   		@mutation_criteria.mutate(offspring: offspring, original_matrix: @original_matrix)
   		@survivor_criteria.select(population: @population)
  		add_new_offspring(offspring)
  		select_best
     # puts "Iteracion: #{i}" if debug
    end
    @best_solution
  end

private
  def select_best
    candidate = Genotype.select_best(candidates: @population)
    @best_solution = @best_solution.fitness_value < candidate.fitness_value ? candidate : @best_solution
  end

  def add_new_offspring(offspring)
   	@population.add(offspring[0])
   	@population.add(offspring[1])
  end

  def set_initial_solution
    @best_solution = @population.first
  end

  def generate_initial_population
   @population = Set.new
    loop do
      permutations = [*0..dimension - 1].shuffle
      @population << Genotype.new(permutations, @original_matrix)
      break if @population.size == @population_size
    end
  end

end
