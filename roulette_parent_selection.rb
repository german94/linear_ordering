require './genotype'

class RouletteParentSelection
  def initialize(num_of_random_elections:, original_matrix:)
    @num_of_random_elections = num_of_random_elections
    @original_matrix = original_matrix
  end

  def select(population:)
    roulette = generate_roulette(population: population)
    first_parent = select_from_roulette(roulette: roulette)
    roulette_without_first_parent = generate_roulette(population: population, without: [first_parent])
    [first_parent, select_from_roulette(roulette_without_first_parent)]
  end

private
  def select_from_roulette(roulette:)
    rand_number = rand
    roulette.each do |elem|
      if elem[:probability] > rand_number
        return elem[:genotype]
      end
    end
  end

  def generate_roulette(population:, without: [])
    population_with_probabilities = generate_probabilities(population: population, without: without)
    roulette = []
    probability_sum = 0
    population_with_probabilities.each do |genotype, probability|
      probability_sum += probability
      roulette << { genotype: genotype, probability: probability_sum }
    end
    roulette
  end

  def generate_probabilities(population:, without:)
    normalized_genotypes = normalize_fitness_values(population: population, without: without)
    normalized_fitness_sum = normalized_genotypes.inject(0) { |sum, current| sum + current[:normalized_fitness_value] }
    population_probabilities = {}
    normalized_genotypes.each do |genotype, normalized_fitness_value|
      population_probabilities[genotype] = normalized_fitness_value.to_f / normalized_fitness_sum
    end
    population_probabilities
  end

  #esto es necesario porque si algun fitness_value es negativo entonces el calculo de la probabilidad se caga
  def normalize_fitness_values(population:, without:)
    min_fitness_value = population.inject(population.first.fitness_value) do |min, candidate_genotype|
      return min if without.include?(candidate_genotype)
      min < candidate_genotype.fitness_value ? min : candidate_genotype.fitness_value
    end
    normalized_genotypes = []
    population.each do |genotype|
      next if without.include?(genotype)
      normalized_genotypes << { genotype: genotype, normalized_fitness_value: genotype.fitness_value + min_fitness_value.abs + 1 }
    end
    normalized_genotypes
  end
end
