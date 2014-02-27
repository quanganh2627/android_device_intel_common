#pragma once

#include <string>
#include <iostream>
#include <sstream>
#include <cstdlib>

namespace GccFix {

	template <typename T>
	std::string to_string(T val)
	{
		std::ostringstream oss;
		oss << val;
		return oss.str();
	}

	inline unsigned long stoul(std::string s)
	{
		return strtoul(s.c_str(), NULL, 0);
	}
}


