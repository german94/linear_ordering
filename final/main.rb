require './genotype'
require './linear_ordering'
require './tournament_parent_selection'
require './linear_ordering'
require './normal_multi_point_crossover'
require './variation_multi_point_crossover'
require './fitness_based_selection'
require './swap_mutation'
require './roulette_parent_selection'

input_array = ARGV
name_input_file = input_array[0]
population_size = input_array[1].to_i
parent_selection = input_array[2].to_s
num_of_random_elections = input_array[3].to_i
crossover_selection = input_array[4].to_s
probability = input_array[5].to_i
max_iterations = input_array[6].to_i


original_matrix = File.readlines(name_input_file).map do |line|
  line.split.map(&:to_i)
end

original_matrix.delete_at(0) #porque lee en primer lugar la dimension de la matriz pero no lo uso

tournament_selection =  TournamentParentSelection.new(num_of_random_elections: num_of_random_elections, original_matrix: original_matrix)
roulette_selection = RouletteParentSelection.new(original_matrix:original_matrix)
selection_criteria = (parent_selection.downcase == 'tournament') ? tournament_selection : roulette_selection
normal_crossover_criteria = NormalMultiPointCrossover.new(matrix:original_matrix)
variation_crossover_criteria = VariationMultiPointCrossover.new(matrix:original_matrix)
selection_crossover = (crossover_selection.downcase == 'normalcrossover') ? normal_crossover_criteria : variation_crossover_criteria
survivor_criteria = FitnessBasedSelection.new
mutation_criteria = SwapMutation.new(probability)
linearOrdering = LinearOrderingSolutionsGenerator.new(population_size: population_size, original_matrix:original_matrix, max_iterations:max_iterations, parent_selection_criteria:selection_criteria, crossover_criteria:selection_crossover, mutation_criteria: mutation_criteria, survivor_criteria: survivor_criteria )
solution = linearOrdering.generate_solution

matrix = solution.create_permuted_matrix(original_matrix)

# OUTPUT
output = File.open( name_input_file + '_out', "w" )

output << "fitness value:"  + "\n"
output << solution.fitness_value.to_s  + "\n"
output << "permutation:"  + "\n"
output << solution.permutations.to_s + "\n"
output << "best matrix" + "\n"
matrix.each do |row|
	output << row.to_s + "\n"
end
output.close