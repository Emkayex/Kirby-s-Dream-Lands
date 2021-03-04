class_name Party
extends Node
"""
The Party class is responsible for tracking/managing a single party of four players
Each networked player is assigned a Party, and up to four local players from each party can play
As a result, up to 16 players can play together if all four networked parties have four local players

When instantiating a party, do not add it to the scene tree
Instead, pass the party to the PartyManager's add_party() function
"""


# The players array tracks the references to the local players
# As players are moved around the scene tree by this class, the references are updated
var players: Array = [
	null,
    null,
    null,
    null,
]


func _ready():
	pass
