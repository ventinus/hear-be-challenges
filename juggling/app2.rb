# this file uses sample data

require 'pry'

# make global variables to store and access circuit and juggler objects
$circuits = []
$jugglers = []

class Juggler
	attr_accessor :name, :coordination, :endurance, :pizzazz, :prefs, :circuit
	
	def initialize(args={})
		@name = args[:name]		
		@coordination = args[:coordination]		
		@endurance = args[:endurance]
		@pizzazz = args[:pizzazz]
		@prefs = args[:prefs]
		@circuit = args[:circuit]
	end	

	def player_stats
		self.coordination + self.endurance + self.pizzazz
	end
end


class Circuit
	attr_accessor :name, :coordination, :endurance, :pizzazz, :jugglers
	def initialize(args={})
		@name = args[:name]		
		@coordination = args[:coordination]	
		@endurance = args[:endurance]	
		@pizzazz = args[:pizzazz]
		@jugglers = []
	end

	def circuit_stats
		self.coordination + self.endurance + self.pizzazz
	end
end

def parse_data_file(file)
	File.open(file) do |f|
		f.each_line do |line|
			line.strip!
	  	# grab all the circuit lines and make circuit objects out of them
	  	if line.start_with?('C')
	  		a = line.split
	  		circuit = Circuit.new({
	  			name: a[1],
	  			coordination: a[2].split(':')[1].to_i,
	  			endurance: a[3].split(':')[1].to_i,
	  			pizzazz: a[4].split(':')[1].to_i
	  			})
	  		# add to global array
	  		$circuits.push(circuit)
	  	# grab all the juggler lines and make juggler objects of them
	  elsif line.start_with?('J')
	  	a = line.split
	  	player_prefs = a[5].split(',')
	  	juggler = Juggler.new({
	  		name: a[1],
	  		coordination: a[2].split(':')[1].to_i,
	  		endurance: a[3].split(':')[1].to_i,
	  		pizzazz: a[4].split(':')[1].to_i,
	  		prefs: player_prefs
	  		})
	  		# add to global array
	  		$jugglers.push(juggler)
	  	end
	  end
	end
	get_limit
end

# method to write results to file
def record_results(file)
	$circuits.each do |circuit|
		File.open(file, "a") do |f|
			f.puts "\n" + circuit.name
			circuit.jugglers.each do |juggler|
				f.write " " + juggler.name
			end
		end
	end
end

# method to get the limit of jugglers on a team
def get_limit
	$limit = $jugglers.length / $circuits.length
end

# assign jugglers to teams
def get_circuit_assignments(collection)
	collection.map do |juggler|
		circuit_prefs = []
		# find the circuit objects each juggler prefers adn add it to the circuit_prefs array
		juggler.prefs.each do |pref|
			circuit_prefs.push($circuits.find{|x| x.name == pref})
		end

		# combine juggler skills and the skills of each circuit
		# jug_skills = juggler.coordination + juggler.endurance + juggler.pizzazz
		skill_totals = []
		circuit_prefs.each do |circuit|
			skill_totals << circuit.circuit_stats
		end

		pref_num = 0
		# while the juggler.circuit attribute is nil and their preference number is less than the amount theyve requested
		while (juggler.circuit == nil) && (pref_num <= circuit_prefs.length)
			if circuit_prefs[pref_num].jugglers.length >= $limit #if this circuit has reached its capacity, check if player is better than any of the current players in the circuit
			a=[] #get the stats of the players in that circuit
			circuit_prefs[pref_num].jugglers.map do |player|
				a << player.player_stats
			end
				if juggler.player_stats > a.min #if the juggler's stats are better than the lowest in the circuit
					to_remove = circuit_prefs[pref_num].jugglers.index{|x| x.player_stats == a.min} #find the index of the lowest to remove
					add_back = circuit_prefs[pref_num].jugglers.delete_at(to_remove) #store the object of that player
					collection.delete(collection.find{|x| x.name == add_back.name}) #remove it from the collection of all players
					add_back.circuit = nil #change circuit attribute of that removed player to nil
					collection.push(add_back) #add player back into colleciton so that it gets run and placed again
					puts "just killed someone"
					circuit_prefs[pref_num].jugglers.push(juggler) #add current juggler to the jugglers newly-opened attribute of circuit
					juggler.circuit = circuit_prefs[pref_num].name #change juggler's circuit attribute to the name of the circuit it is currently in
				else #if the juggler's stats are not better than the lowest in the circuit (generally check next circuit if preference list and then go to last resort)
					puts "i'm being pushed to my limit"
					last_resort = $circuits.find{|x| x.jugglers.length < $limit} # find a circuit that has an empty spot   and circuit doesnt contain this juggler
					last_resort.jugglers.push(juggler) #add juggler to the last_resort circuit
					juggler.circuit = last_resort.name #change juggler's circuit attribute to the name of the last_resort circuit
				end
			else #when desired circuit hasnt reached capacity yet
				circuit_prefs[pref_num].jugglers.push(juggler)  #add juggler to the last_resort circuit
				juggler.circuit = circuit_prefs[pref_num].name #change juggler's circuit attribute to this circuits name 
			end
			pref_num += 1
		end
	end
end

# get and parse the data
parse_data_file('sample-data.txt')

# initial round of assigning
get_circuit_assignments($jugglers)

# loop until all jugglers are on teams
while $jugglers.find{|x| x.circuit == nil}
	left_overs = $jugglers.select{|x| x.circuit == nil}
	get_circuit_assignments(left_overs)
end

# export results to the *results file
record_results('sample-results.txt')