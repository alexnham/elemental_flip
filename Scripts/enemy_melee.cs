using Godot;
using System;

public partial class enemy_melee : Area2D
{
	public float moveSpeed = 1.0f;
	private CharacterBody2D _main_char;
	Vector2 destination;
	[Signal]
	public delegate void DieEventHandler();

	public override void _Ready()
	{
		base._Ready();
		_main_char = GetNode<CharacterBody2D>("../Player");
		Die += die;
	}
	void die() {
		this.QueueFree();
	}
	public override void _Process(double delta)
	{
		
		if(this.Position != _main_char.Position) {
		this.Position = this.Position.MoveToward(_main_char.Position,moveSpeed);
		}
	}
	private void _on_body_entered(Node2D body)
{
	if(body.IsInGroup("Slash")) {
		die();
	}
	if(body.IsInGroup("Player")) {
		GD.Print("ouch");
		_main_char.EmitSignal("EnemyDamage",1);
	}
	
	
}
  
}





