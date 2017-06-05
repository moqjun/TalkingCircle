//
//  TCToolMacroDefinition.h
//  TalkingCircle
//
//  Created by zhaoYuan on 17/4/4.
//  Copyright © 2017年 gongziyuan. All rights reserved.
//

#ifndef TCToolMacroDefinition_h
#define TCToolMacroDefinition_h

#define WEAK_SELF(this_self,weak_self)  __weak typeof(this_self) weak_self = this_self;
#define STRONG_SELF(waek_self,strong_self)  __strong typeof(waek_self) strong_self = waek_self;

#endif /* TCToolMacroDefinition_h */
