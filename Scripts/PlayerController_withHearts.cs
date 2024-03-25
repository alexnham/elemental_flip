using Godot;
using System;

public partial class PlayerController_withHearts : CharacterBody2D
{
	[Signal]
	public delegate void EnemyDamageEventHandler(int amount);
	private float moveSpeed = 400.0f;
	Control ui;
	public float _health = 5;
	char state = 'a';
	public override void _Ready()
	{

		ui = GetNode<Control>("../Interface");
		EnemyDamage += TakeDamage;
	}
	public override void _PhysicsProcess(double delta)
	{
		Vector2 direction = Input.GetVector("left", "right", "up", "down");
		Velocity = direction * moveSpeed;

		MoveAndSlide();
	}
	
	public void TakeDamage(int amount)
	{
		_health -= amount;
		ui.EmitSignal("HealthDepleted", _health);
	}

}
