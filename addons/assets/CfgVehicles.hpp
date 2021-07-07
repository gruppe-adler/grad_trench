class CBA_Extended_EventHandlers;

class CfgVehicles {
    class BagFence_base_F;
    class GRAD_envelope_short: BagFence_base_F {
        model = QPATHTOF(data\trench_short.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_short.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class ACE_envelope_small: BagFence_base_F {
        model = QPATHTOF(data\trench_small.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_small.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class ACE_envelope_big: BagFence_base_F {
        model = QPATHTOF(data\trench_big.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_big.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_giant: BagFence_base_F {
        model = QPATHTOF(data\trench_giant.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_giant.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_vehicle: BagFence_base_F {
        model = QPATHTOF(data\trench_vehicle.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_vehicle.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
    class GRAD_envelope_long: BagFence_base_F {
        model = QPATHTOF(data\trench_long.p3d);
        hiddenSelections[] = {"velka"};
        editorPreview = QPATHTOF(data\trench_long.paa);

        class AnimationSources
        {
            class rise
            {
                source = "user";	// The controller is defined as a user animation.
                animPeriod = 1;		// The animation period used for this controller.
                initPhase = 0;		// Initial phase when object is created.
            };
        };
    };
};
