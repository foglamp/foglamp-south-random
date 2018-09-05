/*
 * FogLAMP south service plugin
 *
 * Copyright (c) 2018 Dianomic Systems
 *
 * Released under the Apache 2.0 Licence
 *
 * Author: Massimiliano Pinto
 */
#include <random.h>
#include <reading.h>

/**
 * Constructor for the random "sensor"
 */
Random::Random()
{
	srand(time(0));
	m_lastValue = rand() % 100;
}

/**
 * Destructor for the random "sensor"
 */
Random::~Random()
{
}

/**
 * Take a reading from the random "sensor"
 */
Reading	Random::takeReading()
{
	m_lastValue += ((rand() % 100) > 50 ? 1 : -1) *
		((rand() % 100) / 20);
	DatapointValue value(m_lastValue);
	return Reading(m_asset_name,new Datapoint("random", value));
}
