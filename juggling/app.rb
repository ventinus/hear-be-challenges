
# needs heavy refactoring from lines 102-296 though i think it basically works?
# this file uses full data


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

def record_results(file)# write results to file
	$circuits.each do |circuit|
		File.open(file, "a") do |f|
			f.puts "\n" + circuit.name
			circuit.jugglers.each do |juggler|
				f.write " " + juggler.name
			end
		end
	end
end

def get_limit
	$limit = $jugglers.length / $circuits.length
end

def get_circuit_assignments(collection)
	collection.map do |juggler|
		circuit_prefs = []
		# find the circuits each juggler prefers adn add it to the circuit_prefs array
		juggler.prefs.each do |pref|
			circuit_prefs.push($circuits.find{|x| x.name == pref})
		end

		# add jugglers to the circuit.jugglers
		if circuit_prefs[0].jugglers.length >= 6
			a=[]
			circuit_prefs[0].jugglers.map do |player|
				a << player.player_stats
			end
			if juggler.player_stats > a.min
				to_remove = circuit_prefs[0].jugglers.index{|x| x.player_stats == a.min}
				add_back = circuit_prefs[0].jugglers.delete_at(to_remove)
				collection.delete(collection.find{|x| x.name == add_back.name})
				add_back.circuit = nil
				collection.push(add_back)
				puts "just killed someone"
				circuit_prefs[0].jugglers.push(juggler)
				juggler.circuit = circuit_prefs[0].name

			elsif circuit_prefs[1].jugglers.length >= 6
				a=[]
				circuit_prefs[1].jugglers.map do |player|
					a << player.player_stats
				end 
				if juggler.player_stats > a.min
					to_remove = circuit_prefs[1].jugglers.index{|x| x.player_stats == a.min}
					add_back = circuit_prefs[1].jugglers.delete_at(to_remove)
					collection.delete(collection.find{|x| x.name == add_back.name})
					add_back.circuit = nil
					collection.push(add_back)
					puts "just killed someone"
					circuit_prefs[1].jugglers.push(juggler)
					juggler.circuit = circuit_prefs[1].name

				elsif circuit_prefs[2].jugglers.length >= 6
					a=[]
					circuit_prefs[2].jugglers.map do |player|
						a << player.player_stats
					end
					if juggler.player_stats > a.min
						to_remove = circuit_prefs[2].jugglers.index{|x| x.player_stats == a.min}
						add_back = circuit_prefs[2].jugglers.delete_at(to_remove)
						collection.delete(collection.find{|x| x.name == add_back.name})
						add_back.circuit = nil
						collection.push(add_back)
						puts "just killed someone"
						circuit_prefs[2].jugglers.push(juggler)
						juggler.circuit = circuit_prefs[2].name

					elsif circuit_prefs[3].jugglers.length >= 6
						a=[]
						circuit_prefs[3].jugglers.map do |player|
							a << player.player_stats
						end 
						if juggler.player_stats > a.min
							to_remove = circuit_prefs[3].jugglers.index{|x| x.player_stats == a.min}
							add_back = circuit_prefs[3].jugglers.delete_at(to_remove)
							collection.delete(collection.find{|x| x.name == add_back.name})
							add_back.circuit = nil
							collection.push(add_back)
							puts "just killed someone"
							circuit_prefs[3].jugglers.push(juggler)
							juggler.circuit = circuit_prefs[3].name

						elsif circuit_prefs[4].jugglers.length >= 6
							a=[]
							circuit_prefs[4].jugglers.map do |player|
								a << player.player_stats
							end 
							if juggler.player_stats > a.min
								to_remove = circuit_prefs[4].jugglers.index{|x| x.player_stats == a.min}
								add_back = circuit_prefs[4].jugglers.delete_at(to_remove)
								collection.delete(collection.find{|x| x.name == add_back.name})
								add_back.circuit = nil
								collection.push(add_back)
								puts "just killed someone"
								circuit_prefs[4].jugglers.push(juggler)
								juggler.circuit = circuit_prefs[4].name

							elsif circuit_prefs[5].jugglers.length >= 6
								a=[]
								circuit_prefs[5].jugglers.map do |player|
									a << player.player_stats
								end 
								if juggler.player_stats > a.min
									to_remove = circuit_prefs[5].jugglers.index{|x| x.player_stats == a.min}
									add_back = circuit_prefs[5].jugglers.delete_at(to_remove)	
									collection.delete(collection.find{|x| x.name == add_back.name})
									add_back.circuit = nil
									collection.push(add_back)
									puts "just killed someone"
									circuit_prefs[5].jugglers.push(juggler)
									juggler.circuit = circuit_prefs[5].name

								elsif circuit_prefs[6].jugglers.length >= 6
									a=[]
									circuit_prefs[6].jugglers.map do |player|
										a << player.player_stats
									end 
									if juggler.player_stats > a.min
										to_remove = circuit_prefs[6].jugglers.index{|x| x.player_stats == a.min}
										add_back = circuit_prefs[6].jugglers.delete_at(to_remove)
										collection.delete(collection.find{|x| x.name == add_back.name})
										add_back.circuit = nil
										collection.push(add_back)
										puts "just killed someone"
										circuit_prefs[6].jugglers.push(juggler)
										juggler.circuit = circuit_prefs[6].name

									elsif circuit_prefs[7].jugglers.length >= 6
										a=[]
										circuit_prefs[7].jugglers.map do |player|
											a << player.player_stats
										end 
										if juggler.player_stats > a.min
											to_remove = circuit_prefs[7].jugglers.index{|x| x.player_stats == a.min}
											add_back = circuit_prefs[7].jugglers.delete_at(to_remove)
											collection.delete(collection.find{|x| x.name == add_back.name})
											add_back.circuit = nil
											collection.push(add_back)
											puts "just killed someone"
											circuit_prefs[7].jugglers.push(juggler)
											juggler.circuit = circuit_prefs[7].name		

										elsif circuit_prefs[8].jugglers.length >= 6
											a=[]
											circuit_prefs[8].jugglers.map do |player|
												a << player.player_stats
											end 
											if juggler.player_stats > a.min
												to_remove = circuit_prefs[8].jugglers.index{|x| x.player_stats == a.min}
												add_back = circuit_prefs[8].jugglers.delete_at(to_remove)
												collection.delete(collection.find{|x| x.name == add_back.name})
												add_back.circuit = nil
												collection.push(add_back)
												puts "just killed someone"
												circuit_prefs[8].jugglers.push(juggler)
												juggler.circuit = circuit_prefs[8].name

											elsif circuit_prefs[9].jugglers.length >= 6
												a=[]
												circuit_prefs[9].jugglers.map do |player|
													a << player.player_stats
												end 
												if juggler.player_stats > a.min
													to_remove = circuit_prefs[9].jugglers.index{|x| x.player_stats == a.min}
													add_back = circuit_prefs[9].jugglers.delete_at(to_remove)
													collection.delete(collection.find{|x| x.name == add_back.name})
													add_back.circuit = nil
													collection.push(add_back)
													puts "just killed someone"
													circuit_prefs[9].jugglers.push(juggler)
													juggler.circuit = circuit_prefs[9].name
												else
													puts "i'm being pushed to my limit"
													last_resort = $circuits.find{|x| x.jugglers.length < 6}
													last_resort.jugglers.push(juggler)
													juggler.circuit = last_resort.name
												end
											else
												circuit_prefs[9].jugglers.push(juggler)
												juggler.circuit = circuit_prefs[9].name
											end
										else
											circuit_prefs[8].jugglers.push(juggler)
											juggler.circuit = circuit_prefs[8].name
										end
									else
										circuit_prefs[7].jugglers.push(juggler)
										juggler.circuit = circuit_prefs[7].name
									end
								else
									circuit_prefs[6].jugglers.push(juggler)
									juggler.circuit = circuit_prefs[6].name
								end
							else
								circuit_prefs[5].jugglers.push(juggler)
								juggler.circuit = circuit_prefs[5].name
							end
						else
							circuit_prefs[4].jugglers.push(juggler)
							juggler.circuit = circuit_prefs[4].name
						end
					else
						circuit_prefs[3].jugglers.push(juggler)
						juggler.circuit = circuit_prefs[3].name
					end
				else
					circuit_prefs[2].jugglers.push(juggler)
					juggler.circuit = circuit_prefs[2].name
				end
			else
				circuit_prefs[1].jugglers.push(juggler)
				juggler.circuit = circuit_prefs[1].name
			end
		else
			circuit_prefs[0].jugglers.push(juggler)
			juggler.circuit = circuit_prefs[0].name
		end
	end
end


# get data
parse_data_file('data.txt')

# initial round of assigning
get_circuit_assignments($jugglers)

# loop until all jugglers are on teams
while $jugglers.find{|x| x.circuit == nil}
	left_overs = $jugglers.select{|x| x.circuit == nil}
	get_circuit_assignments(left_overs)
end

# write results to file
record_results('results.txt')


# first answer: 17,787

# jugglers on circuit 1970: 
# J2594 J2602 J4445 J4761 J6510 J7850
# second answer: 28,762
