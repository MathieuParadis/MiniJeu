require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "----------------------------------------------------------------------------------------------------"
puts "                          |    Bienvenue sur 'ILS VEULENT TOUS MA POO'!  |"
puts "                          |Le but du jeu est d'être le dernier survivant!|                          "
puts "----------------------------------------------------------------------------------------------------"
print "\n"

puts "Entre le nom de ton joueur"
print "> "
username_input = gets.chomp
my_game = Game.new(username_input)

print "\n"
puts "C'est parti mon kiki"

round = 0

while my_game.human_player.life_points > 0 && my_game.players_left > 0 do
  round += 1
  puts "_______________________________________________________________________________________________________"
  gets.chomp

  puts "ROUND #{round}"
  gets.chomp

  puts "Il reste #{my_game.players_left} ennemies"
  print "\n"


  puts "Voici l'état de ton personnage: "
  my_game.human_player.show_state
  print "\n"

  my_game.new_players_in_sight

  my_game.menu_choice(my_game.menu)

  my_game.enemies_attack
  
  if my_game.human_player.life_points > 0
    puts "Fin du round #{round}"
    print "Il reste #{my_game.players_left} ennemies"
    gets.chomp
  else
    break
  end
end

my_game.end
# print "\n"
# puts "La partie est finie"
# puts user.life_points > 0 ? "BRAVO ! TU AS GAGNE !"  : "Loser ! Tu as perdu !" 
