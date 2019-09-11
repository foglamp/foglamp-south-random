#ifndef _RANDOM_H
#define _RANDOM_H
/*
 * Fledge south service plugin
 *
 * Copyright (c) 2018 Dianomic Systems
 *
 * Released under the Apache 2.0 Licence
 *
 * Author: Mark Riddoch, Massimiliano Pinto
 */
#include <reading.h>

class Random {
	public:
		Random();
		~Random();
		Reading		takeReading();
	void	setAssetName(const std::string& assetName)
		{
			m_asset_name = assetName;
		}

	private:
		long		m_lastValue;
		std::string	m_asset_name;
};
#endif
