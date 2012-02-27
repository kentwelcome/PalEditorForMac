//
//  PalDataStructure.h
//  PalEditorForMac
//
//  Created by Huang Kent on 12/2/27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef PalEditorForMac_PalDataStructure_h
#define PalEditorForMac_PalDataStructure_h

#define MONEY_OFFSET    0x28
#define EXP_OFFSET      0x7c
#define LEVEL_OFFSET    0x244

struct PalExp {
    uint32 nowExp;
    uint32 needExp;
};

struct PalMoney {
    uint32 money;
};

struct PalRole {
    uint32 level;
};

#endif
