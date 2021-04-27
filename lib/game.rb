class Game
  attr_accessor :human_player
  attr_accessor :enemies_in_sight
  attr_accessor :players_left

  def initialize(human_player)
    #initialiation du joueur
    @human_player = HumanPlayer.new(human_player)

    #initialisation des enemies
    @players_left = 10
    @enemies_in_sight = []
  end

  def kill_player(player)
    @enemies_in_sight = @enemies_in_sight.reject{ |enemie| enemie == player}
    @players_left -= 1
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0 ? true : false
  end
  
  def show_players
    puts "Voici l'état de ton personnage :"
    @human_player.show_state
    print "\n"

    puts "Voici le nombre d'énemies restant :"
    puts @enemies_in_sight.length
  end 

  def menu
  puts "Quelle action veux-tu effectuer ?"
  print "\n"
  puts "a - chercher une meilleur arme"
  puts "s - chercher à se soigner"
  print "\n"

  puts "attaquer un joueur en vue :"
    for i in 0..@enemies_in_sight.length-1
      print "#{i} - "

      if @enemies_in_sight[i].life_points == 0
        puts "#{@enemies_in_sight[i].name} est mort, tu ne peux plus l'attaquer"
      else
        print "#{@enemies_in_sight[i].show_state}"
      end
      i += 1
    end

    print "\n"
    print "> "
    gets.chomp
  end

  def menu_choice(choice)
    print "\n"

    #check if any enemie has lifepoints to 0, and remove it if it is the case
    if @enemies_in_sight.any? { |player| player.life_points == 0 } 
      kill_player(@enemies_in_sight.select{ |player| player.life_points == 0 }[0])
    end

    case choice
      when "a" then @human_player.search_weapon
      when "s" then @human_player.search_health_pack
      when "0".."#{@enemies_in_sight.length - 1}" then @human_player.attack(@enemies_in_sight[choice.to_i])
      else 
        puts "mauvaise commande"
        puts "Tu perds un tour" 
        print "\n"
    end
    
  end

  def enemies_attack
    #check if any enemie has lifepoints to 0, and remove it if it is the case
    if @enemies_in_sight.any? { |player| player.life_points == 0 } 
      kill_player(@enemies_in_sight.select{ |player| player.life_points == 0 }[0])
    end

    if @enemies_in_sight.length > 0
      puts "Les autres joueurs t'attaquent !"
      print "\n"
      @enemies_in_sight.map { |enemie| @human_player.life_points > 0 ? enemie.attack(@human_player): break}
    end
  end 

  def end
    puts "La partie est finie."
    puts @human_player.life_points > 0 ? "BRAVO ! TU AS GAGNE !"  : "Loser ! Tu as perdu !" 
  end

  def new_players_in_sight
    if @enemies_in_sight.length == @players_left
      puts "Tous les joueurs sont déjà en vue"
      print "\n"
    else
      case rand(1..6)
        when 1 
          puts "Pas d'ennemie en vue"
        when 2..4 
          player1 = Player.new(generate_player_name(5))
          @enemies_in_sight.push(player1)
          puts "1 nouvel ennemie en vue"
        when 5..6
          player1 = Player.new(generate_player_name(5))
          player2 = Player.new(generate_player_name(5))
          @enemies_in_sight.push(player1)
          @enemies_in_sight.push(player2)
          puts "2 nouveaux ennemies arrivent"
      end
    end
    gets.chomp
  end

  def generate_player_name(number_of_characters)
    charset = Array('a'..'z')
    Array.new(number_of_characters) { charset.sample }.join
  end

end
