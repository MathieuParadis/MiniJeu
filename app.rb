require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

  player1 = Player.new("Josiane")
  player2 = Player.new("Jose")

while player1.life_points > 0 && player2.life_points > 0 do
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  gets.chomp

  puts "Passons à la phase d'attaque :"
  gets.chomp

  player1.attack(player2)

  if player2.life_points <= 0
    break
  else
    player2.attack(player1)
  end

end
