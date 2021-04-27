class Player 
  attr_accessor :name
  attr_accessor :life_points

  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie"
  end

  def gets_damage(damage_received)
    @life_points -= damage_received
    @life_points = @life_points.clamp(0, 100)
    if @life_points > 0 
      show_state 
    else
      puts "Le joueur #{@name} a été tué"
    end
  end

  def attack(player)
    puts "Le joueur #{@name} attaque le joueur #{player.name}"
    damage_attack = compute_damage
    puts "Il lui inflige #{damage_attack} points de dégats"

    player.gets_damage(damage_attack)
    gets.chomp
  end

  def compute_damage
    return rand(1..6)
  end
   
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    @name = name
    @life_points = 100
    @weapon_level = 1
  end

  def show_state
    puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"

    if new_weapon_level > @weapon_level
      @weapon_level = new_weapon_level
      puts  "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."

    end
  end

  def search_health_pack
    health_pack = rand(1..6)

    case health_pack 
    when 1 then 
      puts "Tu n'as rien trouvé... "
    when 6 then 
      puts "Waow, tu as trouvé un pack de +80 points de vie !"
      @life_points += 80
      @life_points = @life_points.clamp(0, 100)
      show_state
    else
      puts "Bravo, tu as trouvé un pack de +50 points de vie !"
      @life_points += 50
      @life_points = @life_points.clamp(0, 100)
      show_state
    end
  end

end