using Godot;
using System;
using System.Runtime.Serialization;

public partial class Bullet : CharacterBody2D
{
    [Signal]
    public delegate void HitEventHandler();
    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        
    }


    private void _on_hit(){
        this.Visible = false;
        this.QueueFree();
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
    {
    }
}
