using Godot;
using Godot.NativeInterop;
using System;
using System.Net.Http;
// using System.Runtime.CompilerServices;

public partial class Dungeon : Node2D
{
  // Enemy
  // private Godot.Sprite2D player;
  // private Godot.Sprite2D enemy;
  // private Godot.Sprite2D bullet;
  // private Godot.CharacterBody2D enemyShooting;
  // private Vector2 playerPosition;
  // private Vector2 enemyPosition;
  // private Vector2 enemyShootingPosition;
  // private Boolean touched;
  // private Boolean shot;
  // PackedScene bulletScene;

  // [Signal]
  // public delegate void ();
  // public delegate void ShootEventHandler(int oldValue, int newValue);
  // Called when the node enters the scene tree for the first time.
  public override void _Ready()
  {
	// touched = false;
	// shot = false;

	// Godot.Sprite2D player = this.GetNode<Sprite2D>("Player");
	// Godot.Sprite2D enemy = this.GetNode<Sprite2D>("Enemy");
	// Godot.CharacterBody2D enemyShooting = this.GetNode<CharacterBody2D>("Enemy_Shooting");
	// bulletScene = (PackedScene)GD.Load("res://Scenes/bullet.tscn");

	// this.player = player;
	// this.enemy = enemy;
	// this.enemyShooting = enemyShooting;
	// Godot.Sprite2D bullet = enemy.GetNode<Sprite2D>("Bullet");
	// playerPosition = player.GlobalPosition;
	// enemyPosition = enemy.GlobalPosition;
	// enemyShootingPosition = enemyShooting.Position;

	// bullet.Visible = false;
	// bullet.ShowBehindParent = true;

	// this.bullet = bullet;
  }

  // private float FollowSpeed = 5.0f;
  // private Vector2 velocity = new Vector2(10, 10);

  public override void _PhysicsProcess(double delta)
  {

	// playerPosition = player.GlobalPosition;
	// var collisionInfo = enemyShooting.MoveAndCollide(playerPosition * (float)delta);

	// var collisionInfo = enemyShooting.MoveAndCollide(velocity * (float)delta);
	// if (collisionInfo != null)
	// {
	//   GD.Print("TOuched!");
	//   // touched = true;
	// }
	// base._PhysicsProcess(delta);
	// Vector2 bulletPosition = bullet.GlobalPosition;
	// bullet.GlobalPosition = bullet.GlobalPosition.Lerp(playerPosition, (float)delta * FollowSpeed);
	// GD.Print("Player position = " + playerPosition);

	// enemyPosition = enemy.GlobalPosition;
	// enemy.GlobalPosition = enemyPosition.Lerp(playerPosition, (float)delta * FollowSpeed);

	// enemyShootingPosition = enemyShooting.GlobalPosition;
	// if (touched == false)
	// {
	// enemyShootingPosition = enemy.Position;
	// enemyShooting.Position = enemyShootingPosition.MoveToward(player.Position, (float)delta * FollowSpeed);

	// GD.Print("Player position = " + playerPosition);
	// GD.Print("Shooting position = " + enemyShootingPosition);

	// if (shot == true)
	// {
	//   GD.Print("Bullet started");

	//   CharacterBody2D bullet = (CharacterBody2D)bulletScene.Instantiate();
	//   bullet.GlobalPosition = enemyShooting.GetNode<Marker2D>("BulletSpawnPosition").GlobalPosition;
	//   // bullet.GlobalPosition = this.enemy.Position;
	//   enemyShooting.AddChild(bullet);

	//   GD.Print("Bullet done\n");
	//   shot = false;
	// }
	// }

	// if (touched == false)
	// {

	// }

  }



  // Called every frame. 'delta' is the elapsed time since the previous frame.
  // private float moveSpeed = 1.0f;
  public override void _Process(double delta)
  {
	// float AMOUNT = 5;
	// if (Input.IsKeyPressed(Key.W))
	// {
	//   player.Position += new Vector2(0, -AMOUNT);
	// }

	// if (Input.IsKeyPressed(Key.S))
	// {
	//   player.Position += new Vector2(0, AMOUNT);
	// }

	// if (Input.IsKeyPressed(Key.A))
	// {
	//   player.Position += new Vector2(-AMOUNT, 0);
	// }

	// if (Input.IsKeyPressed(Key.D))
	// {
	//   player.Position += new Vector2(AMOUNT, 0);
	// }

	// this.playerPosition = player.GlobalPosition;

	// if (Input.IsKeyPressed(Key.Space))
	// {
	//   shot = true;
	// }

	// if (enemyShooting.GlobalPosition != player.GlobalPosition)
	// {
	//   enemyShooting.GlobalPosition = enemyShooting.GlobalPosition.MoveToward(player.GlobalPosition, moveSpeed);
	// }
  }
}
