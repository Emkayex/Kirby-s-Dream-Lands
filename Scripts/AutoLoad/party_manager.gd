extends Node
"""
The PartyManager class is responsible for managing the parties connected to the server
"""


# The parties array tracks the currently connected parties and adds/removes them within the scene tree
var parties: Array = [
	null,
	null,
	null,
	null,
]


func _ready():
	pass


remotesync func add_party(party: Party) -> int:
	# Put the party into the parties array
	for i in range(len(parties)):
		if parties[i] == null:
			parties[i] = party

			# Add the party into the scene tree and return a successful status code
			add_child(party)
			return CustomStatus.OK
	
	# If the party was unable to be added to the scene tree due to all slots being filled, return an error
	return CustomStatus.ALL_PARTIES_FILLED


remotesync func remove_party(party: Party) -> int:
	# Find the party's index or return an INVALID_PARTY error if it does not exist
	var i: int = 0
	for member in parties:
		if party == member:
			return remove_party_by_index(i)

		# If this party does not match the passed one, increment the index
		i += 1
	
	return CustomStatus.INVALID_PARTY



remotesync func remove_party_by_index(i: int) -> int:
	if parties[i] == null:
		return CustomStatus.INVALID_PARTY
	
	# If the party is valid, remove it from the scene tree and return an OK
	remove_child(parties[i])
	parties[i].queue_free()
	parties[i] = null
	return CustomStatus.OK
