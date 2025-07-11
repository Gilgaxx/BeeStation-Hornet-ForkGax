/obj/item/computer_hardware/network_card
	name = "network card"
	desc = "A basic wireless network card for usage with standard NTNet frequencies."
	power_usage = 50
	icon_state = "radio_mini"
	network_id = NETWORK_CARDS	// Network we are on
	var/hardware_id = null	// Identification ID. Technically MAC address of this device. Can't be changed by user.
	var/identification_string = "" 	// Identification string, technically nickname seen in the network. Can be set by user.
	/// If this works without being on the same zlevel, as long as there is a tcomms relay
	var/long_range = FALSE
	/// If this works without a tcomms relay on the zlevel (requires long_range)
	var/ignore_relay = FALSE
	var/ethernet = FALSE // Hard-wired, therefore always on, ignores NTNet wireless checks.
	malfunction_probability = 1
	device_type = MC_NET
	custom_price = 10


/obj/item/computer_hardware/network_card/LateInitialize()
	. = ..()
	hardware_id = GetComponent(/datum/component/ntnet_interface).hardware_id

/obj/item/computer_hardware/network_card/diagnostics(var/mob/user)
	..()
	to_chat(user, "NIX Unique ID: [hardware_id]")
	to_chat(user, "NIX User Tag: [identification_string]")
	to_chat(user, "Supported protocols:")
	to_chat(user, "511.m SFS (Subspace) - Standard Frequency Spread")
	if(long_range)
		to_chat(user, "511.n WFS/HB (Subspace) - Wide Frequency Spread/High Bandiwdth")
	if(ethernet)
		to_chat(user, "OpenEth (Physical Connection) - Physical network connection port")


// Returns a string identifier of this network card
/obj/item/computer_hardware/network_card/proc/get_network_tag()
	return "[identification_string] (NID [hardware_id])"

// 0 - No signal, 1 - Low signal, 2 - High signal. 3 - Wired Connection
/obj/item/computer_hardware/network_card/proc/get_signal(var/specific_action = 0)
	if(!holder) // Hardware is not installed in anything. No signal. How did this even get called?
		return 0

	if(!check_functionality())
		return 0

	if(ethernet) // Computer is connected via wired connection.
		return 3

	if(!SSnetworks.station_network || !SSnetworks.station_network.check_function(specific_action, get_virtual_z_level(), ignore_relay)) // NTNet is down and we are not connected via wired connection. No signal.
		return 0

	if(holder)

		var/turf/T = get_turf(holder)
		if((T && istype(T)) && (is_station_level(T.z) || is_mining_level(T.z)))
			// Computer is on station. Low/High signal depending on what type of network card you have
			if(long_range)
				return 2
			else
				return 1

	if(long_range) // Computer is not on station, but it has upgraded network card. Low signal.
		return 1

	return 0 // Computer is not on station and does not have upgraded network card. No signal.


/obj/item/computer_hardware/network_card/advanced
	name = "advanced network card"
	desc = "An advanced network card for usage with standard NTNet frequencies. Its transmitter is strong enough to connect even off-station."
	long_range = TRUE
	power_usage = 100 // Better range but higher power usage.
	icon_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	custom_price = 40

/obj/item/computer_hardware/network_card/advanced/norelay
	name = "ultra-advanced network card"
	desc = "An advanced network card for usage with standard NTNet frequencies. Its transmitter is strong enough to connect even off-station, even without a telecomms relay."
	ignore_relay = TRUE
	icon_state = "no-relay"
	custom_price = 100

/obj/item/computer_hardware/network_card/wired
	name = "wired network card"
	desc = "An advanced network card for usage with standard NTNet frequencies. This one also supports wired connection."
	ethernet = 1
	power_usage = 100 // Better range but higher power usage.
	icon_state = "net_wired"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/computer_hardware/network_card/integrated //Borg tablet version, only works while the borg has power and is not locked
	name = "cyborg data link"

/obj/item/computer_hardware/network_card/integrated/get_signal(specific_action = 0)
	var/obj/item/modular_computer/tablet/integrated/modularInterface = holder

	if(!modularInterface || !istype(modularInterface))
		return FALSE //wrong type of tablet

	if(!modularInterface.borgo)
		return FALSE //No borg found

	var/mob/living/silicon/robot/robo = modularInterface.borgo
	if(istype(robo))
		if(robo.lockcharge)
			return FALSE //lockdown restricts borg networking

		if(!robo.cell || robo.cell.charge == 0)
			return FALSE //borg cell dying restricts borg networking

	return ..()
