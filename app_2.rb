require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "----------------------------------------------------------------------------------------------------"
puts "                          |    Bienvenue sur 'ILS VEULENT TOUS MA POO'!  |"
puts "                          |Le but du jeu est d'être le dernier survivant!|                          "
puts "----------------------------------------------------------------------------------------------------"
print "\n"

#Initialisation du joueur
puts "Entre le nom de ton joueur"
print "> "
username_input = gets.chomp
user = HumanPlayer.new(username_input)

#Initialisation des ennemis
player1 = Player.new("Josiane")
player2 = Player.new("Jose")
players_array = [player1, player2]

round = 0

print "\n"
puts "C'est parti mon kiki"

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0) do
  round += 1
  puts "_______________________________________________________________________________________________________"
  gets.chomp
  puts "ROUND #{round}"
  gets.chomp

  puts "Voici l'état de ton personnage: "
  user.show_state
  print "\n"

  puts "Quelle action veux-tu effectuer ?"
  print "\n"
  puts "a - chercher une meilleur arme"
  puts "s - chercher à se soigner"
  print "\n"

  puts "attaquer un joueur en vue :"
  print "0 - "
  print "#{player1.show_state}"
  print "1 - "
  print "#{player2.show_state}"
  
  print "\n"
  print "> "
  user_choice = gets.chomp
  print "\n"

  case user_choice
    when "a" then user.search_weapon
    when "s" then user.search_health_pack
    when "0" then user.attack(player1)
    when "1" then user.attack(player2)
    else 
      puts "mauvaise commande"
      puts "Tu perds un tour" 
      print "\n"
    end


    if players_array.any? { |player| player.life_points > 0} == true
      puts "Les autres joueurs t'attaquent !"
      print "\n"
      players_array.select { |player| player.life_points > 0 }.map { |player| player.attack(user) }
  end
  
  puts "Fin du #{round} round"
end

puts "La partie est finie"
puts user.life_points > 0 ? "BRAVO ! TU AS GAGNE !"  : "Loser ! Tu as perdu !" 
