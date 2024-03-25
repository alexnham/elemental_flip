using Godot;
using System;

public partial class EnemyShooting : CharacterBody2D
{
  public const float Speed = 300.0f;
  public const float JumpVelocity = -400.0f;
  private Vector2 velocity = new Vector2(100, 100);
  Boolean touched;
  private CharacterBody2D mainChar;
  private Sprite2D player;
  private PackedScene mainCharScene;
  private PackedScene enemyShootingScene;
  private PackedScene bulletScene;
  public override void _Ready()
  {

	mainChar = GetNode<CharacterBody2D>("../MainCharacter");

	// mainCharScene = (PackedScene)GD.Load("res://Scenes/MainCharacter.tscn");
	// mainChar = GetNode<CharacterBody2D>("../MainCharacter");
	// enemyShootingScene = (PackedScene)GD.Load("res://Scenes/Dungeon.tscn");
	// touched = false;

	// CharacterBody2D mainCharBody = (CharacterBody2D)mainCharScene.Instantiate();


	// base._Ready();
  }
  // Get the gravity from the project settings to be synced with RigidBody nodes.
  // public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

  public override void _PhysicsProcess(double delta)
  {


	// var collisionInfo = MoveAndCollide(mainChar.Position * (float)delta);
	// if (collisionInfo != null)
	// {
	//   touched = true;
	// }
	// Vector2 velocity = Velocity;

	// Add the gravity.
	// if (!IsOnFloor())
	// 	velocity.Y += gravity * (float)delta;

	// Handle Jump.
	// if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
	// 	velocity.Y = JumpVelocity;

	// Get the input direction and handle the movement/deceleration.
	// As good practice, you should replace UI actions with custom gameplay actions.
	// Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down");
	// if (direction != Vector2.Zero)
	// {
	// 	velocity.X = direction.X * Speed;
	// }
	// else
	// {
	// 	velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
	// }

	// Velocity = velocity;
	// MoveAndSlide();
  }

  private float speed = 1.0f;
  public override void _Process(double delta)
  {
	// if (touched == false)
	// {
	//   this.GlobalPosition = this.GlobalPosition.MoveToward(mainChar.GlobalPosition, (float)(delta * speed));
	// }

	// if (touched == false)
	// {

	// }

	if (this.Position != mainChar.Position)
	{
	  this.Position = this.Position.MoveToward(mainChar.Position, speed);
	}

	// base._Process(delta);
  }
}
