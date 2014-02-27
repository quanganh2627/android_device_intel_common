/******************************************************************************
** Copyright (c) 2014 Intel Corporation All Rights Reserved
**
** Licensed under the Apache License, Version 2.0 (the "License"); you may not
** use this file except in compliance with the License.
**
** You may obtain a copy of the License at
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
** WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
**
** See the License for the specific language governing permissions and
** limitations under the License.
**
******************************************************************************/

#pragma once

#include "Dptf.h"
#include "BasicTypes.h"
#include "DptfExport.h"

class XmlNode;

class Temperature final
{
public:

    Temperature(void);
    Temperature(UInt32 temperature);
    UInt32 getTemperature() const;
    Bool isTemperatureValid() const;
    Bool operator==(const Temperature& rhs) const;
    Bool operator!=(const Temperature& rhs) const;
    Bool operator>(const Temperature& rhs) const;
    Bool operator>=(const Temperature& rhs) const;
    Bool operator<(const Temperature& rhs) const;
    Bool operator<=(const Temperature& rhs) const;

    std::string toString() const;
    XmlNode* getXml(std::string tag);

    static const UInt32 invalidTemperature = 0xFFFFFFFF;

private:

    UInt32 m_temperature;
    Bool isTemperatureValid(UInt32 temperature) const;
    void throwIfTemperatureNotValid(UInt32 lhs, UInt32 rhs) const;
    static const UInt32 maxValidTemperature = 2500;
};