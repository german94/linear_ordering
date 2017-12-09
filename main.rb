require './genotype'
require './linear_ordering'
require './tournament_parent_selection'
require './linear_ordering'
require './middle_point_crossover'
require './fitness_based_selection'
require './swap_mutation'


input_array = ARGV
name_input_file = input_array[0]
probability = input_array[1].to_i
population_size = input_array[2].to_i
num_of_random_elections = input_array[3].to_i
max_iterations = input_array[4].to_i


######
original_matrix = File.readlines(name_input_file).map do |line|
  line.split.map(&:to_i)
end

original_matrix.delete_at(0) #porque lee en primer lugar la dimension de la matriz pero no lo uso


#######
tournamentParent = TournamentParentSelection.new(num_of_random_elections: num_of_random_elections, original_matrix: original_matrix)
crossover_criteria = MiddlePointCrossover.new(matrix:original_matrix)
survivor_criteria = FitnessBasedSelection.new
mutation_criteria = SwapMutation.new(probability)
linearOrdering = LinearOrderingSolutionsGenerator.new(population_size: population_size, original_matrix:original_matrix, max_iterations:max_iterations, parent_selection_criteria:tournamentParent, crossover_criteria:crossover_criteria, mutation_criteria: mutation_criteria, survivor_criteria: survivor_criteria )
solution = linearOrdering.generate_solution

matrix = solution.create_permuted_matrix(original_matrix)

# OUTPUT
output = File.open( name_input_file + "out", "w" )
output << "best matrix" + "\n"
matrix.each do |row|
	output << row.to_s + "\n"
end
output << "best fitness value:"  + "\n"
output << solution.fitness_value.to_s  + "\n"
output << "permutation:"  + "\n"
output << solution.rows.to_s 
output << solution.cols.to_s + "\n"
output.close